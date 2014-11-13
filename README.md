Xors3d-to-PHP
=============

Xors3d to PHP

Этот проект был сделан в качестве примера использования https://github.com/Dionix/Xors3D-to-Delphi

Пртестировано на PHP(4\5)Delphi 2009 - 2010 - XE2 - XE7 


Пример использования 

----------------------------------------------------------------------------------------------------------------------
{
xGraphics3D(800, 600, 32, False, True);

xSetBuffer(xBackBuffer());

$TypePlayer=1;
$TypeWall=2;

$Player=xCreateSphere(16, 0);

xEntityType($Player,$TypePlayer, 0);

$Wall=xCreateCube(0);

xPositionEntity($Wall,0,0,10,0);

xEntityType($Wall,$TypeWall, 0);

xCollisions($TypePlayer,$TypeWall,2,3);

$cam=xCreateCamera(0);

xPositionEntity($cam,0,30,0, 0);

xTurnEntity($cam,90,0,0,0);

$lit=xCreateLight(1);

xTurnEntity($lit,70,70,0,0);


while(!xKeyDown(KEY_ESCAPE))
{

	If (xKeyDown(200)) xMoveEntity($Player,0,0,1,0);
	If (xKeyDown(208)) xMoveEntity($Player,0,0,-1,0);
	If (xKeyDown(203)) xMoveEntity($Player,0,-1,0,0);
	If (xKeyDown(205)) xMoveEntity($Player,0,1,0,0);


	xUpdateWorld(1);

	xRenderWorld(1, 0);

	xFlip();

};
}
