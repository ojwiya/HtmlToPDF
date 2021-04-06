#!/bin/bash

dotnet publish HtmlToPDF -f "netcoreapp3.1" --configuration Release

TargetStage=dev
Stack="Html2PDF"

cd HtmlToPDF/bin/Release/netcoreapp3.1/publish
sam package --template-file serverless.yaml --s3-bucket codts --output-template-file out.yaml --debug
sam deploy --template-file out.yaml --stack-name $Stack --capabilities CAPABILITY_IAM --no-fail-on-empty-changeset --parameter-overrides TargetStage=$TargetStage