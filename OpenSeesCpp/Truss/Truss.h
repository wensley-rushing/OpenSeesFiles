/*
 * @Author: Mengsen.Wang
 * @Date: 2020-07-18 01:22:32
 * @Last Modified by: Mengsen.Wang
 * @Last Modified time: 2020-07-20 16:46:57
 */

#ifndef Truss_h
#define Truss_h

// Description: This file contains the class definition for Truss. A Truss
// object provides the abstraction of the small deformation bar element. Each
// truss object is associated with a material object. This Truss element will
// work in 1d, 2d or 3d problems.
//
// What: "@(#) Truss.h, revA"

#include <Element.h>
#include <Matrix.h>

class Node;
class Channel;
class UniaxialMaterial;

class Truss : public Element {
 public:
  Truss(int tag, int dimension, int Nd1, int Nd2, UniaxialMaterial &theMaterial,
        double A, double rho = 0.0, int doRayleighDamping = 0, int cMass = 0);

  Truss();
  ~Truss();

  const char *getClassType(void) const { return "Truss"; };

  // public methods to obtain information about dof & connectivity
  int getNumExternalNodes(void) const;
  const ID &getExternalNodes(void);
  Node **getNodePtrs(void);
  int getNumDOF(void);

  //* not virtual
  void setDomain(Domain *theDomain);

  //! un-virtual

  // public methods to set the state of the element
  int commitState(void);
  int revertToLastCommit(void);
  int revertToStart(void);
  int update(void);

  //! un-virtual

  // public methods to obtain stiffness, mass, damping and residual information
  const Matrix &getTangentStiff(void);
  const Matrix &getInitialStiff(void);
  const Matrix &getDamp(void);
  const Matrix &getMass(void);

  //* not virtual
  //! un-used
  const Matrix &getKi(void);

  void zeroLoad(void);
  int addLoad(ElementalLoad *theLoad, double loadFactor);
  int addInertiaLoadToUnbalance(const Vector &accel);

  const Vector &getResistingForce(void);
  const Vector &getResistingForceIncInertia(void);

  // public methods for element output
  Response *setResponse(const char **argv, int argc, OPS_Stream &s);
  int getResponse(int responseID, Information &eleInformation);

  int displaySelf(Renderer &, int mode, float fact,
                  const char **displayModes = 0, int numModes = 0);

  void Print(OPS_Stream &s, int flag = 0);
  int sendSelf(int commitTag, Channel &theChannel);
  int recvSelf(int commitTag, Channel &theChannel, FEM_ObjectBroker &theBroker);

  // AddingSensitivity:BEGIN
  int addInertiaLoadSensitivityToUnbalance(const Vector &accel, bool tag);

  int setParameter(const char **argv, int argc, Parameter &param);
  int updateParameter(int parameterID, Information &info);
  int activateParameter(int parameterID);

  const Vector &getResistingForceSensitivity(int gradNumber);

  const Matrix &getKiSensitivity(int gradNumber);
  const Matrix &getMassSensitivity(int gradNumber);
  int commitSensitivity(int gradNumber, int numGrads);
  // AddingSensitivity:END

  //! un-virtual
  // const Matrix &getGeometricTangentStiff();
  // bool isSubdomain(void);
  // double getCharacteristicLength(void);
  // int addload(ElementLoad *theLoad, const Vector &LoadFactor);
  // int setRayleighDampingFactors(double alphaM, double betaK, double betaK0,
  // double betaKc);
  // virtual int addResistingForceToNodalReaction(int flag);
  // virtual int storePreviousK(int numK);
  // virtual const Matrix *getPreviousK(int num);

 protected:
 private:
  double computeCurrentStrain(void) const;
  double computeCurrentStrainRate(void) const;

  // private attributes - a copy for each object of the class
  UniaxialMaterial *theMaterial;  // pointer to a material
  ID connectedExternalNodes;      // contains the tags of the end nodes
  int dimension;                  // truss in 2 or 3d domain
  int numDOF;                     // number of dof for truss

  Vector *theLoad;    // pointer to the load vector P
  Matrix *theMatrix;  // pointer to objects matrix (a class wide Matrix)
  Vector *theVector;  // pointer to objects vector (a class wide Vector)

  double L;               // length of truss based on undeformed configuration
  double A;               // area of truss
  double rho;             // rho: mass density per unit length
  int doRayleighDamping;  // flag to include Rayleigh damping
  int cMass;              // consistent mass flag

  double cosX[3];  // direction cosines with Local coordinate system

  Node *theNodes[2];
  double *initialDisp;

  // AddingSensitivity:BEGIN
  int parameterID;
  Vector *theLoadSens;
  // AddingSensitivity:END

  // static data - single copy for all objects of the class
  static Matrix trussM2;   // class wide matrix for 2*2
  static Matrix trussM4;   // class wide matrix for 4*4
  static Matrix trussM6;   // class wide matrix for 6*6
  static Matrix trussM12;  // class wide matrix for 12*12
  static Vector trussV2;   // class wide Vector for size 2
  static Vector trussV4;   // class wide Vector for size 4
  static Vector trussV6;   // class wide Vector for size 6
  static Vector trussV12;  // class wide Vector for size 12
};

#endif
