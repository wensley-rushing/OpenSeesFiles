#  * @Author: Mengsen.Wang
#  * @Date: 2020-03-18 15:11:52
#  * @Last Modified by:   Mengsen.Wang
#  * @Last Modified time: 2020-03-18 15:11:52

#  * @Description: 单纯为壳单元共计4个

for { set Storey 1 } { $Storey < 3 } { incr Storey } {
    for { set i 1 } { $i < 3 } { incr i } {
        set nodelTagi [expr $Storey * 100 + $i]
        set nodelTagj [expr $Storey * 100 + ($i + 1)]
        set nodelTagk [expr ($Storey + 1) * 100 + $i]
        set nodelTagl [expr ($Storey + 1) * 100 + ($i + 1)]
        set eleTag [expr $Storey * 10 + $i]
        element ShellMITC4 $eleTag $nodelTagi $nodelTagj $nodelTagl $nodelTagk 1
    }
}

element truss 1 102 202 10 3
element truss 2 202 302 10 3
