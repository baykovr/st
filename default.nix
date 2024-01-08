{ pkgs }:
{
  stt = pkgs.st.overrideAttrs(oldAttrs: {
    patches = [ ./patches/stt.diff ];
  });
}
