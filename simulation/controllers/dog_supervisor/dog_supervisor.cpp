// File:          dog_supervisor.cpp
// Date:
// Description:
// Author:
// Modifications:

// You may need to add webots include files such as
// <webots/DistanceSensor.hpp>, <webots/Motor.hpp>, etc.
// and/or to add some other includes

#include <webots/Supervisor.hpp>
#include <Eigen>
#include <iostream>
#include <fstream>
#include <string>

// All the webots classes are defined in the "webots" namespace
using namespace std;
using namespace webots;
using namespace Eigen;

void ThreePoint(double* point, Block<MatrixXf> target, int i);
void fourPoint(double* point, Block<MatrixXf> target, int i);

int main(int argc, char **argv) {
  // create the Robot instance.
	Supervisor* robot = new Supervisor();

  // get the time step of the current world.
  int timeStep = (int)robot->getBasicTimeStep();

  //string pointfilename = "lowjump_pointdata.txt";
  //string targetfilename = "lowjump_targetpose.txt";
  //int frames = 45;

  //string pointfilename = "midjump_pointdata.txt";
  //string targetfilename = "midjump_targetpose.txt";
  //int frames = 57;
  
  //string pointfilename = "heightjump_pointdata.txt";
  //string targetfilename = "heightjump_targetpose.txt";
  //int frames = 57;

  //string pointfilename = "ringjump1_pointdata.txt";
  //string targetfilename = "ringjump1_targetpose.txt";
  //int frames = 55;

  string pointfilename = "ringjump2_pointdata.txt";
  string targetfilename = "ringjump2_targetpose.txt";
  int frames = 45;

  // import data
  ifstream file(pointfilename);
  if (!file.is_open()) {
      cerr << "无法打开文件" << endl;
      return -1;
  }

  int rows = frames, cols = 27;
  Eigen::MatrixXf matrix(rows, cols);
  string line, cell;
  int i = 0, j = 0;
  while (getline(file, line)) {
      stringstream ss(line);
      while (getline(ss,cell,',')) {
          matrix(i, j) = stof(cell);
          j++;
      }
      i++;
      j = 0;//因为忘了把这个清零，一直报从超过数组最大值的错误
  }

  file.close();
  // 打印矩阵
  //cout << "读取的矩阵为：" << endl << matrix << endl;
  //cout << "读取的矩阵行列为：" << matrix.rows() << "  " << matrix.cols() << endl;

  //读取go2的姿势数据
  ifstream go2Pose(targetfilename);
  if (!go2Pose.is_open()) {
      cerr << "无法打开文件" << endl;
      return -1;
  }

  rows = frames;
  cols = 19;
  Eigen::MatrixXf go2matrix(rows, cols);

  i = 0;
  j = 0;
  while (getline(go2Pose, line)) {
      stringstream ss(line);

      while (getline(ss, cell, ',')) {

          go2matrix(i, j) = stof(cell);
          j++;
      }
      i++;
      j = 0;//因为忘了把这个清零，一直报从超过数组最大值的错误
  }

  go2Pose.close();
// 打印矩阵
//cout << "读取的矩阵为：" << endl << go2matrix << endl;
//cout << "读取的矩阵行列为：" << go2matrix.rows() << "  " << go2matrix.cols() << endl;

  //解包数据
  //警犬数据
  Block<MatrixXf> comS = matrix.block(0, 0, matrix.rows(), 3);

  Block<MatrixXf> hipRFS = matrix.block(0, 3, matrix.rows(), 3);
  Block<MatrixXf> footRFS = matrix.block(0, 6, matrix.rows(), 3);

  Block<MatrixXf> hipLFS = matrix.block(0, 9, matrix.rows(), 3);
  Block<MatrixXf>  footLFS = matrix.block(0, 12, matrix.rows(), 3);

  Block<MatrixXf> hipRHS = matrix.block(0, 15, matrix.rows(), 3);
  Block<MatrixXf> footRHS = matrix.block(0, 18, matrix.rows(), 3);

  Block<MatrixXf> hipLHS = matrix.block(0, 21, matrix.rows(), 3);
  Block<MatrixXf> footLHS = matrix.block(0, 24, matrix.rows(), 3);
  //cout << "读取的矩阵为：" << endl << hipLHS << endl;
  //GO2数据
  Block<MatrixXf> go2Pos = go2matrix.block(0, 0, go2matrix.rows(), 3);
  Block<MatrixXf> go2Rot = go2matrix.block(0, 3, go2matrix.rows(), 4);
  Block<MatrixXf> go2RF = go2matrix.block(0, 7, go2matrix.rows(), 3);
  Block<MatrixXf> go2LF = go2matrix.block(0, 10, go2matrix.rows(), 3);
  Block<MatrixXf> go2RH = go2matrix.block(0, 13, go2matrix.rows(), 3);
  Block<MatrixXf> go2LH = go2matrix.block(0, 16, go2matrix.rows(), 3);
  //cout << "读取的矩阵为：" << endl << go2LH << endl;

  // 定义节点
  Node* hipRF = robot->getFromDef("hipRF");
  Field* hipRFPos = hipRF->getField("translation");

  Node* footRF = robot->getFromDef("footRF");
  Field* footRFPos = footRF->getField("translation");

  Node* hipLF = robot->getFromDef("hipLF");
  Field* hipLFPos = hipLF->getField("translation");

  Node* footLF = robot->getFromDef("footLF");
  Field* footLFPos = footLF->getField("translation");

  Node* hipRH = robot->getFromDef("hipRH");
  Field* hipRHPos = hipRH->getField("translation");

  Node* footRH = robot->getFromDef("footRH");
  Field* footRHPos = footRH->getField("translation");

  Node* hipLH = robot->getFromDef("hipLH");
  Field* hipLHPos = hipLH->getField("translation");

  Node* footLH = robot->getFromDef("footLH");
  Field* footLHPos = footLH->getField("translation");

  Node* COM = robot->getFromDef("COM");
  Field* COMPos = COM->getField("translation");

  //GO2节点
  Node* GO2 = robot->getFromDef("GO2");
  Field* GO2ComPos = GO2->getField("translation");
  Field* GO2Rot = GO2->getField("rotation");

  Field* GO2HipRF = robot->getFromDef("HIPRF")->getField("position");
  Field* GO2HipLF = robot->getFromDef("HIPLF")->getField("position");
  Field* GO2HipRH = robot->getFromDef("HIPRH")->getField("position");
  Field* GO2HipLH = robot->getFromDef("HIPLH")->getField("position");
  //有两种设置关节角度的方式，第一种是用setJointPosition，这种方式要获取关节节点
  // 第二种是setSFFloat，这种方式要获取position field
  // 第一种方式运行比较慢，第二种方式运行速度快
  //Node* GO2HipRF = robot->getFromDef("HIPRF");

  Field* GO2ThighRF = robot->getFromDef("thighRF")->getField("position");
  Field* GO2ThighLF = robot->getFromDef("thighLF")->getField("position");
  Field* GO2ThighRH = robot->getFromDef("thighRH")->getField("position");
  Field* GO2ThighLH = robot->getFromDef("thighLH")->getField("position");

  Field* GO2CalfRF = robot->getFromDef("calfRF")->getField("position");
  Field* GO2CalfLF = robot->getFromDef("calfLF")->getField("position");
  Field* GO2CalfRH = robot->getFromDef("calfRH")->getField("position");
  Field* GO2CalfLH = robot->getFromDef("calfLH")->getField("position");


  //GO2HipRF->setJointPosition(3, 1);
  double newpos[3] = { -1.04,-0.03,0.34 };
  double newrot[4] = { 0,0,0,0 };
  
  COMPos->setSFVec3f(newpos);
  GO2ComPos->setSFVec3f(newpos);
  const double* pos;

  while (robot->step(timeStep) != -1) {
      if (i >= rows) {
          i = 0;
      }
      //警犬点位
      ThreePoint(newpos, hipRFS, i);
      hipRFPos->setSFVec3f(newpos);

      ThreePoint(newpos, footRFS, i);
      footRFPos->setSFVec3f(newpos);
      //cout << "右前脚小球：" << *newpos << endl;
      ThreePoint(newpos, hipLFS, i);
      hipLFPos->setSFVec3f(newpos);

      ThreePoint(newpos, footLFS, i);
      footLFPos->setSFVec3f(newpos);

      ThreePoint(newpos, hipRHS, i);
      hipRHPos->setSFVec3f(newpos);

      ThreePoint(newpos, footRHS, i);
      footRHPos->setSFVec3f(newpos);

      ThreePoint(newpos, hipLHS, i);
      hipLHPos->setSFVec3f(newpos);

      ThreePoint(newpos, footLHS, i);
      footLHPos->setSFVec3f(newpos);

      ThreePoint(newpos, comS, i);
      COMPos->setSFVec3f(newpos);

      //GO2身体位置

      ThreePoint(newpos, go2Pos, i);
      GO2ComPos->setSFVec3f(newpos);
      cout << "des pos：" << *newpos << " " << *(newpos + 1) << " " << *(newpos + 2) << endl;
      pos = GO2->getPosition();
      cout <<"real pos：" << *pos << " " << *(pos + 1) << " " << *(pos + 2) << endl;
      cout << " " << endl;
      fourPoint(newrot, go2Rot, i);
      GO2Rot->setSFRotation(newrot);


      GO2HipRF->setSFFloat(go2RF(i, 0));
      GO2HipLF->setSFFloat(go2LF(i, 0));
      GO2HipRH->setSFFloat(go2RH(i, 0));
      GO2HipLH->setSFFloat(go2LH(i, 0));

      GO2ThighRF->setSFFloat(go2RF(i, 1));
      GO2ThighLF->setSFFloat(go2LF(i, 1));
      GO2ThighRH->setSFFloat(go2RH(i, 1));
      GO2ThighLH->setSFFloat(go2LH(i, 1));

      GO2CalfRF->setSFFloat(go2RF(i, 2));
      GO2CalfLF->setSFFloat(go2LF(i, 2));
      GO2CalfRH->setSFFloat(go2RH(i, 2));
      GO2CalfLH->setSFFloat(go2LH(i, 2));

      i++;
       
  };



  delete robot;
  return 0;
}


void ThreePoint(double* point, Block<MatrixXf> target, int i) {
    point[0] = target(i, 0);
    point[1] = target(i, 1);
    point[2] = target(i, 2);
}

void fourPoint(double* point, Block<MatrixXf> target, int i) {
    point[0] = target(i, 0);
    point[1] = target(i, 1);
    point[2] = target(i, 2);
    point[3] = target(i, 3);
}