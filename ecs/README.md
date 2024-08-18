# ECS

ECSクラスタとクラスタ内にALBを構築するTerraform。

なお、ALBのTargetGroupはアプリケーションごとに用意するため、ecs-serviceプロジェクトで作成する。

## 前提条件

- vpcプロジェクトを実行済み