#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: DockerRequirement
    dockerPull: "skgrid"
  - class: ScatterFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: SubworkflowFeatureRequirement


inputs:
  cancer: string[]
  platform: string[]

outputs:
  train:
    doc: tbd
    type: File[]
    outputBinding:
      glob: "*.model"
    outputSource: train_model/train



steps:
  train_model:
    in:
      cancer: cancer
      platform: platform
    scatter: [cancer, platform]
    scatterMethod: dotproduct
    out: [train]
    run: ../tools/skgrid-train.cwl
