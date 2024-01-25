{ lib, buildPythonPackage, fetchPypi, callPackage, mock, cairosvg, klein, jinja2, buildbot-pkg }:
{
  # this is exposed for potential plugins to use and for nix-update
  inherit buildbot-pkg;
  www = buildPythonPackage rec {
    pname = "buildbot-www";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-bu22WXJ2yBGe89GL3RBxkUN/yPu2GEYURk6C+2LIpns=";
    };

    # Remove unnecessary circular dependency on buildbot
    postPatch = ''
      sed -i "s/'buildbot'//" setup.py
    '';

    buildInputs = [ buildbot-pkg mock ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot UI";
      maintainers = with maintainers; [ ryansydnor lopsided98 ];
      license = licenses.gpl2;
    };
  };

  www-react = buildPythonPackage rec {
    pname = "buildbot-www-react";
    inherit (buildbot-pkg) version;
    format = "wheel";

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-WDtw4wSAPsmIRcoZS1PIRzQR4OJnHVyc19Q7MnU5VSs=";
    };

    # Remove unneccessary circular dependency on buildbot
    postPatch = ''
      pushd dist
      unzip buildbot_www_react-${version}-py3-none-any.whl
      sed -i "s/Requires-Dist: buildbot//" buildbot_www_react-${version}.dist-info/METADATA
      chmod -R u+w buildbot_www_react-${version}-py3-none-any.whl
      zip -r buildbot_www_react-${version}-py3-none-any.whl buildbot_www_react-${version}.dist-info
      popd
    '';

    buildInputs = [ buildbot-pkg ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot UI (React)";
      maintainers = with maintainers; [ mic92 ];
      license = licenses.gpl2Only;
    };
  };

  console-view = buildPythonPackage rec {
    pname = "buildbot-console-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-HGlKu9ptej35GJYBBWted/YtsH/uigckAoFAjYTh3gY=";
    };

    buildInputs = [ buildbot-pkg ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Console View Plugin";
      maintainers = with maintainers; [ ryansydnor lopsided98 ];
      license = licenses.gpl2;
    };
  };

  react-console-view = buildPythonPackage rec {
    pname = "buildbot-react-console-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-oFbR4NvI/6oPXY8TospkHS1j/5KzXd1fguazFtDPIko=";
    };

    buildInputs = [ buildbot-pkg ];

    # tests fail
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Console View Plugin (React)";
      maintainers = teams.buildbot.members;
      license = licenses.gpl2;
    };
  };

  waterfall-view = buildPythonPackage rec {
    pname = "buildbot-waterfall-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-O4scYAKpoEOXsPIodkKUrfwCGNYHlOGfvDnguaM12U0=";
    };

    buildInputs = [ buildbot-pkg ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Waterfall View Plugin";
      maintainers = with maintainers; [ ryansydnor lopsided98 ];
      license = licenses.gpl2;
    };
  };

  react-waterfall-view = buildPythonPackage rec {
    pname = "buildbot-react-waterfall-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-DlYqK32lVdZ8qby/1+JCo6m81/0dsxqiAfWMIZ1OAPQ=";
    };

    buildInputs = [ buildbot-pkg ];

    # tests fail
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Waterfall View Plugin (React)";
      maintainers = teams.buildbot.members;
      license = licenses.gpl2;
    };
  };

  grid-view = buildPythonPackage rec {
    pname = "buildbot-grid-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-cK+uZU7rG423IT8xvwrpMPiUXfu1oPpGB5onmWNK4fs=";
    };

    buildInputs = [ buildbot-pkg ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Grid View Plugin";
      maintainers = with maintainers; [ lopsided98 ];
      license = licenses.gpl2;
    };
  };

  react-grid-view = buildPythonPackage rec {
    pname = "buildbot-react-grid-view";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-Gbc0T1fsmke1pO/LiXCzQYrjWzYG1WhHZgypLyzhfok=";
    };

    buildInputs = [ buildbot-pkg ];

    # tests fail
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Grid View Plugin (React)";
      maintainers = teams.buildbot.members;
      license = licenses.gpl2;
    };
  };

  wsgi-dashboards = buildPythonPackage rec {
    pname = "buildbot-wsgi-dashboards";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-eFfOYhKw575VWlwD5dKRnqjSUV6kdPrv3UXBs/3AREo=";
    };

    buildInputs = [ buildbot-pkg ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot WSGI dashboards Plugin";
      maintainers = with maintainers; [ lopsided98 ];
      license = licenses.gpl2;
    };
  };

  badges = buildPythonPackage rec {
    pname = "buildbot-badges";
    inherit (buildbot-pkg) version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-FNMspluhQlGgQ4X7gJisakHTTmn/5PtQ+obK26PrXdg=";
    };

    buildInputs = [ buildbot-pkg ];
    propagatedBuildInputs = [ cairosvg klein jinja2 ];

    # No tests
    doCheck = false;

    meta = with lib; {
      homepage = "https://buildbot.net/";
      description = "Buildbot Badges Plugin";
      maintainers = with maintainers; [ julienmalka ];
      license = licenses.gpl2;
    };
  };

}
