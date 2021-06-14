{ lib, buildPythonPackage, fetchPypi, requests, jmespath, mock, pytest }:

buildPythonPackage rec {
  pname = "iotlabcli";
  version = "3.2.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "03b8fg553lzb2y9i6asq8il8kahdxk1rm4ympzxb3r1kigcp98bv";
  };
  doCheck = false;
  #checkInputs = [ pytest mock ];
  propagatedBuildInputs = [ jmespath requests ];

  meta = with lib; {
    homepage = "http://github.com/iot-lab/cli-tools/";
    description = "Manage IoT-LAB experiments from the command-line.";
    license = licenses.cecill20;
    maintainers = with maintainers; [ rgrunbla ];
  };
}