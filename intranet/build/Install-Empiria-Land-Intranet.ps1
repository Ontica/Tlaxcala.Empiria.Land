# Script:	 Install-Empiria-Land-Intranet
# Purpose:   Installs Empiria Land Intranet libraries for development.

# Copyright (c) 2017. La Vía Óntica, SC, Ontica LLC and contributors.

$libraries_url = "http://www.ontica.org/empiria/libraries/"
$destination_path = Join-Path $pwd '..\..\libs\'

# Create libs directory if it not exists
if(!(Test-Path -Path $destination_path)) {
  "Creating libs directory"
  New-Item -ItemType directory -Path $destination_path
}


"Downloading libraries from [$libraries_url] ..."

$source = -join($libraries_url, 'C1.Win.C1BarCode.2.dll')
$target = -join($destination_path, 'C1.Win.C1BarCode.2.dll')

wget $source -OutFile $target

$source = -join($libraries_url, 'PDFTechLib.dll')
$target = -join($destination_path, 'PDFTechLib.dll')

wget $source -OutFile $target

"Installation was successful"
