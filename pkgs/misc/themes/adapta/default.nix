{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, parallel, sassc, inkscape, libxml2, glib, gdk_pixbuf, librsvg, gtk-engine-murrine, gnome3 }:

stdenv.mkDerivation rec {
  name = "adapta-gtk-theme-${version}";
  version = "3.94.0.132";

  src = fetchFromGitHub {
    owner = "adapta-project";
    repo = "adapta-gtk-theme";
    rev = version;
    sha256 = "11j4mpbw8x2vg0w740v8q3rnwannw2zhp60aj8kirqlgz76lbadl";
  };

  preferLocalBuild = true;

  nativeBuildInputs = [
    autoreconfHook
    pkgconfig
    parallel
    sassc
    inkscape
    libxml2
    glib.dev
    gnome3.gnome-shell
  ];

  buildInputs = [
    gdk_pixbuf
    librsvg
  ];

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];

  postPatch = "patchShebangs .";

  configureFlags = [
    "--disable-gtk_legacy"
    "--disable-gtk_next"
    "--disable-unity"
  ];

  meta = with stdenv.lib; {
    description = "An adaptive Gtk+ theme based on Material Design Guidelines";
    homepage = https://github.com/adapta-project/adapta-gtk-theme;
    license = with licenses; [ gpl2 cc-by-sa-30 ];
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
