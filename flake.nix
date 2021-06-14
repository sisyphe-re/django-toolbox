{
  description = "A flake for django-celery-beat";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-21.05;

  outputs = { self, nixpkgs }:
    {
      packages.x86_64-linux.django-timezone-field =
        with import nixpkgs { system = "x86_64-linux"; };
        python3Packages.buildPythonPackage
          rec {
            pname = "django-timezone-field";
            version = "4.1.2";

            src = python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-z/rGJFLQYONlk4qpyfe3LXDYsmucYCQ7ziJ7NavRud8=";
            };

            doCheck = false;
            propagatedBuildInputs = with python3Packages; [ django_3 ];

            meta = with lib; {
              homepage = "https://github.com/mfogel/django-timezone-field/";
              description = "A Django app providing database, form and serializer fields for pytz timezone objects.";
              license = licenses.bsd2;
              maintainers = with maintainers; [ rgrunbla ];
            };
          };
      packages.x86_64-linux.django-celery-beat =
        with import nixpkgs { system = "x86_64-linux"; };
        python3Packages.buildPythonPackage
          rec {
            pname = "django-celery-beat";
            version = "2.2.0";

            src = python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-uKE6+xXnxT/AT0+EescabTIIiVmrpwHrfEpZ8MKLpUM=";
            };
            doCheck = false;
            propagatedBuildInputs =
              with python3Packages;
              [ django_3 celery python-crontab self.packages.x86_64-linux.django-timezone-field ];

            meta = with lib; {
              homepage = "https://github.com/celery/django-celery-beat";
              description = "Database-backed Periodic Tasks";
              license = licenses.bsd3;
              maintainers = with maintainers; [ rgrunbla ];
            };
          };
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.django-celery-beat;
    };
}
