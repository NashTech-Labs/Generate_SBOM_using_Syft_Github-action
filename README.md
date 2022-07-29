# Generate_SBOM_using_Syft

## Introduction

The main SBOM action, responsible for generating SBOMs and uploading them as workflow artifacts and release assets.A GitHub Action for creating a software bill of materials (SBOM) using Syft.

**test.yaml**

```
name: GitHub Action for SBOM Generation using Syft
on:
  push:
    branches: [ main ]
    
jobs:
  build:
    runs-on: ubuntu-18.04
    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Package Frontend
      run: |
        docker build -t test-image .
    - uses: anchore/sbom-action@v0
      with: 
        image: test-image:latest
        artifact-name: report.spdx-json
        output-file: ./report.spdx-json
    
    - uses: anchore/sbom-action/publish-sbom@v0
      with:
        sbom-artifact-match: ".*\\.spdx$"    

    - name: cat
      run: |
        pwd
        ls
        cat report.spdx-json
        
```        
**Basic Usage**
```
- uses: anchore/sbom-action@v0
```

By default, this action will execute a Syft scan in the workspace directory and upload a workflow artifact SBOM in SPDX format. It will also detect if being run during a GitHub release and upload the SBOM as a release asset.

**Example Usage**

**Scan a container image**

To scan a container image, use the image parameter
```
    - uses: anchore/sbom-action@v0
      with: 
        image: test-image:latest
```
**Publishing SBOMs with releases**

```
- uses: anchore/sbom-action/publish-sbom@v0
  with:
    sbom-artifact-match: ".*\\.spdx$"
```

**Naming the SBOM output**

 simply we can use the *artifact-name* parameter
 
```
- uses: anchore/sbom-action@v0
  with:
    artifact-name: sbom.spdx
```    

It does have diffrent format also

The SBOM format to export. One of: spdx, spdx-json, cyclonedx, cyclonedx-json.And the default one is spdx-json.
