'''
Date: 2021-02-17 14:04:25
Author: Mengsen Wang
LastEditors: Mengsen Wang
LastEditTime: 2021-04-09 11:58:01
FilePath: \OpenSeesFiles\Lib\PythonLib\model_view.py
'''
''' OpenSees Visual Interface
This package will watch your OpenSees file(s) and generate a live preview
'''


# Declare OpenSees tcl files to watch and refresh rate
# NB: Must be tuple. If only one file, make sure it is in parentheses and
#     followed by a comma.
# Eg - One file -  tclfiles = ('example.tcl',)
# Eg - Two files - tclfiles = ('example1.tcl', 'example2.tcl')
import os
import time
import matplotlib.pyplot as pl
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D
tclfiles = ('nodes.tcl',)

# Specify the refresh rate of the viewer. 1 second is default and works well
# for small models. For larger models you may want to increase the time.
refresh_rate = 1  # time between viewer refresh (in seconds)


# Set viewport visual style
bg_colour = 'lightgrey'  # background colour
pl.rc('font', family='Monospace', size=10)  # set font for labels
node_style = {'color': 'black', 'marker': '.', 'markersize': 10}  # nodes
ele_style = {'color': 'black', 'linewidth': 1, 'linestyle': '-'}  # elements
axis_style = {'color': 'grey', 'linewidth': 1,
              'linestyle': '--'}  # x=0, y=0 lines
offset = 0.05  # offset for text
# 2D
bc_style = {'color': 'black', 'markeredgewidth': 1, 'markersize': 9,
            'fillstyle': 'none'}  # node translation fixity (boundary conditions)
bcrot_style = {'color': 'black', 'markeredgewidth': 1, 'markersize': 10,
               'fillstyle': 'none'}  # node rotation fixity (boundary conditions)
# 3D
azimuth = -50  # degrees
elevation = 20  # degrees
bc_style3d = {'length': 0.3, 'arrow_length_ratio': 0.5, 'colors': 'black'}
bcrot_style3d = {}


def flatten_tcl(tclfiles):
    ''' This function takes a tcl file and rewrites it to a temporary file.
    The new temporary file will be flattened, meaning all expressions are
    replaced with their evaluated value (as a float)
    '''
    import os

    variables = {}  # a disctionary of variables set in the tcl file
    tempfiles = []  # a list of the temporary files created
    ns = {'__builtins__': None}  # create empty namespace to use eval() safely

    for tclfile in tclfiles:
        tempfiles.append(tclfile[:-4]+'_temp.tcl')

        with open(tclfile) as f_in, open(tempfiles[-1], 'w') as f_out:
            for line in f_in:
                # For lines that define variable, add that variable to dictionary
                if line[:3] == 'set':
                    # If the line has 3 words, the variable is set directly and we
                    #  can add it to our dictionary of variable values
                    if len(line.split()) == 3:
                        variables['$'+line.split()[1]] = float(line.split()[2])
                        f_out.write(line)
                    # If the thrid word is an expression, evaluate before write
                    elif '[expr' in line.split()[2]:
                        expr = line[line.find('[expr ')+6:line.find(']')]
                        for variable in variables:
                            if variable in expr:
                                # If variables in expr, replace with value
                                expr = expr.replace(variable,
                                                    str(variables[variable]))
                        # Replace expression with evaluated value of expression
                        expr = eval(expr, ns)
                        variables['$'+line.split()[1]] = float(expr)
                        f_out.write(
                            ' '.join(('set', line.split()[1], str(expr))))
                # For lines that don't define variable, eval expressions and print
                else:
                    for variable in variables:
                        line = line.replace(variable, str(variables[variable]))
                    while '[expr' in line:  # evaluate any expressions, then print
                        expr = line[line.find('[expr ')+6:line.find(']')]
                        line = line.replace(
                            '[expr '+expr+']', str(eval(expr, ns)))
                    f_out.write(line)

    # Combine all _temp tcl files into one messy one, also detect for 3D of 2D
    ndm = 2  # assume 3 dimensions unless '-ndm 2' detected
    with open('temp.tcl', 'w') as f:
        for tempfile in tempfiles:
            with open(tempfile, 'r') as temp:
                for line in temp:
                    f.write(line)
                    if ndm == 2 and '-ndm 3' in line:
                        ndm = 3
                    if ndm == 3 and '-ndm 2' in line:
                        ndm = 'Uh oh, we\'re not sure which ndm to use...'
            os.remove(tempfile)

    return 'temp.tcl', ndm


def update_viewport_2d(frame, tclfiles):
    ''' This function clears a matplotlib figure axis, then reads through your
    tclfiles to determine locations of nodes, elements and fix conditions. It
    then plots these things. It uses a flattened file generated by
    flatten_tcl() so that expressions and variables can be supported.
    '''
    tclfile, ndm = flatten_tcl(tclfiles)
    ax.clear()
    ax.set_xticks([])
    ax.set_yticks([])  # hide axis tick marks/scale
    ax.axhline(**axis_style)
    ax.axvline(**axis_style)  # draw axis lines

    # Read node info
    nodes = []
    with open(tclfile) as f:
        for line in f:
            if 'node' in line[:4] and len(line.split()) == 4:
                # Append [node tag, coordinate 1, coordinate 2]
                node = line.split()
                nodes.append((int(node[1]), float(node[2]), float(node[3])))

    # Read element info
    elements = []
    with open(tclfile) as f:
        for line in f:
            if 'element' in line[:7] and len(line.split()) >= 5:
                # Append [element type, element tag, iNode, jNode]
                ele = line.split()
                elements.append(
                    (ele[1], int(ele[2]), int(ele[3]), int(ele[4])))

    # Read boundary conditions
    fixities = []
    with open(tclfile) as f:
        for line in f:
            if 'fix' in line[:3] and len(line.split()) == 5:
                # Append [node tag, df1, df2, df3]
                fix = line.split()
                fixities.append((int(fix[1]), int(fix[2]),
                                 int(fix[3]), int(fix[4])))

    # Display nodes
    if nodes:  # make sure some nodes exist before using them
        for node in nodes:
            ax.plot(node[1], node[2], linewidth=0, **node_style)
            ax.text(node[1]+offset, node[2]+offset,
                    'N'+str(node[0]), fontweight='bold')  # label node

    # Function that returns node coords from a nodetag
    def nodecoords(nodetag, nodes=nodes):
        for node in nodes:
            if node[0] == nodetag:
                return node[1], node[2]  # Coord-1 and Coord-2
                break

    # Display elements
    if nodes and elements:  # make sure some elements exist before using them
        for element in elements:
            iNode = nodecoords(element[2])
            jNode = nodecoords(element[3])
            if iNode and jNode:  # make sure both nodes exist before using them
                ax.plot((iNode[0], jNode[0]), (iNode[1], jNode[1]),
                        marker='', **ele_style)
                ax.text(offset+(iNode[0]+jNode[0])/2,
                        offset+(iNode[1]+jNode[1])/2,
                        'E'+str(element[1]))  # label element

    # Display boundary conditions
    if fixities:  # make sure some boundary conditions exist before using them
        for fixity in fixities:
            if any(fixity[0] in node for node in nodes):  # make sure node exists
                node_x, node_y = nodecoords(fixity[0])
                if fixity[1] == 1:  # DOF 1 fixed
                    ax.plot(node_x-offset, node_y, marker='>', **bc_style)
                if fixity[2] == 1:  # DOF 2 fixed
                    ax.plot(node_x, node_y-offset, marker='^', **bc_style)
                if fixity[3] == 1:  # DOF 3 fixed
                    ax.plot(node_x, node_y, marker='o', **bcrot_style)

    os.remove(tclfile)


def update_viewport_3d(frame, tclfiles):
    ''' This function clears a matplotlib figure axis, then reads through your
    tclfiles to determine locations of nodes, elements and fix conditions. It
    then plots these things. It uses a flattened file generated by
    flatten_tcl() so that expressions and variables can be supported.
    '''
    tclfile, ndm = flatten_tcl(tclfiles)
    ax.clear()
    ax.set_axis_off()
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_zticks([])  # hide tick marks/scale

    # Read node info
    nodes = []
    with open(tclfile) as f:
        for line in f:
            if 'node' in line[:4] and len(line.split()) == 5:
                # Append [node tag, coordinate 1, coordinate 2]
                node = line.split()
                nodes.append((int(node[1]), float(node[2]),
                              float(node[3]), float(node[4])))

    # Read element info
    elements = []
    with open(tclfile) as f:
        for line in f:
            if 'element' in line[:7] and len(line.split()) >= 5:
                # Append [element type, element tag, iNode, jNode]
                ele = line.split()
                elements.append(
                    (ele[1], int(ele[2]), int(ele[3]), int(ele[4])))

    # Read boundary conditions
    fixities = []
    with open(tclfile) as f:
        for line in f:
            if 'fix' in line[:3] and len(line.split()) == 8:
                # Append [node tag, df1, df2, df3]
                fix = line.split()
                fixities.append([int(fix[i]) for i in range(1, 8)])

    # Display nodes
    if nodes:  # make sure some nodes exist before using them
        for node in nodes:
            ax.scatter(xs=node[1], ys=node[2], zs=node[3], **node_style)
            # ax.scatter(xs=node[1], ys=node[2], zs=node[3],
            #         linewidth=0, **node_style)
            ax.text(x=node[1]+offset, y=node[2]+offset, z=node[3]+offset,
                    s='N'+str(node[0]), fontweight='bold')  # label node

    # Scale axes to preserve aspect ratio of 1
    node_mins = list(nodes[0][1:4])
    node_maxs = list(nodes[0][1:4])
    for node in nodes:
        for i in range(0, 3):
            if node[i+1] < node_mins[i]:
                node_mins[i] = node[i+1]
            if node[i+1] > node_maxs[i]:
                node_maxs[i] = node[i+1]
    view_centre = [(i+j)/2 for i, j in zip(node_maxs, node_mins)]
    view_range = max(node_maxs) - min(node_mins)
    ax.set_xlim(view_centre[0]-(view_range/2), view_centre[0]+(view_range/2))
    ax.set_ylim(view_centre[1]-(view_range/2), view_centre[1]+(view_range/2))
    ax.set_zlim(view_centre[2]-(view_range/2), view_centre[2]+(view_range/2))

    # Draw axes at origin
    ax.plot(xs=(0.0, 1.2*(view_centre[0]+(view_range/2))),
            ys=(0, 0), zs=(0, 0), **axis_style)
    ax.plot(ys=(0.0, 1.2*(view_centre[1]+(view_range/2))),
            xs=(0, 0), zs=(0, 0), **axis_style)
    ax.plot(zs=(0.0, 1.2*(view_centre[2]+(view_range/2))),
            xs=(0, 0), ys=(0, 0), **axis_style)

    # Function that returns node coords from a nodetag
    def nodecoords(nodetag, nodes=nodes):
        for node in nodes:
            if node[0] == nodetag:
                return node[1], node[2], node[3]  # Coord-1, Coord-2, Coord-3
                break

    # Display elements
    if nodes and elements:  # make sure some elements exist before using them
        for element in elements:
            iNode = nodecoords(element[2])
            jNode = nodecoords(element[3])
            if iNode and jNode:  # make sure both nodes exist before using them
                ax.plot(xs=(iNode[0], jNode[0]), ys=(iNode[1], jNode[1]),
                        zs=(iNode[2], jNode[2]), marker='', **ele_style)
                ax.text(x=offset+(iNode[0]+jNode[0])/2,
                        y=offset+(iNode[1]+jNode[1])/2,
                        z=offset+(iNode[2]+jNode[2])/2,
                        s='E'+str(element[1]))  # label element

    # Display boundary conditions
    if fixities:  # make sure some boundary conditions exist before using them
        for fixity in fixities:
            if any(fixity[0] in node for node in nodes):  # make sure node exists
                node_x, node_y, node_z = nodecoords(fixity[0])
                if fixity[1] == 1:  # DOF 1 fixed
                    ax.quiver(node_x-offset, node_y, node_z,
                              1, 0, 0, pivot='tip', **bc_style3d)
                if fixity[2] == 1:  # DOF 2 fixed
                    ax.quiver(node_x, node_y-offset, node_z,
                              0, 1, 0, pivot='tip', **bc_style3d)
                if fixity[3] == 1:  # DOF 3 fixed
                    ax.quiver(node_x, node_y, node_z-offset,
                              0, 0, 1, pivot='tip', **bc_style3d)
    os.remove(tclfile)


# Determine if we have 2D or 3D model
tclfile, ndm = flatten_tcl(tclfiles)
os.remove(tclfile)

# Create figure
if ndm == 2:
    fig = pl.figure(figsize=(6, 6))
    ax = fig.add_subplot(1, 1, 1, aspect=1, frameon=False)
    fig.set_facecolor(bg_colour)
    fig.text(0.01, 0.01, ', '.join(tclfiles),
             va='bottom', ha='left', color='grey', fontweight='bold')  # display file
    fig.subplots_adjust(left=0.08, bottom=0.08, right=0.92, top=0.92)

    ani = animation.FuncAnimation(fig, update_viewport_2d, interval=refresh_rate*1000,
                                  fargs=(tclfiles,))
elif ndm == 3:
    fig = pl.figure(figsize=(8, 8))
    ax = fig.add_subplot(1, 1, 1, projection='3d')
    ax.view_init(elev=elevation, azim=azimuth)
    ax.set_facecolor(bg_colour)
    fig.subplots_adjust(left=0.00, bottom=0.00, right=1.00, top=1.00)
    node_style['markersize'] *= 5
    node_style['s'] = node_style.pop('markersize')  # 's' is used in scatter
    fig.text(0.01, 0.01, ', '.join(tclfiles),
             va='bottom', ha='left', color='grey', fontweight='bold')  # display file

    ani = animation.FuncAnimation(fig, update_viewport_3d, interval=refresh_rate*1000,
                                  fargs=(tclfiles,))
else:
    print(ndm)

pl.show()
