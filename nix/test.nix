{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "gotests";

  src = fetchFromGitHub {
    owner = "cweill";
    repo = "gotests";
    rev = "2435ae532b971c836a98aa497a0f3a07b73c3488";
    sha256 = "0pvy6lwckzgk4lfm9wbx9l6nw6nihpsalpd5vylddarnf6jz4li8";
  };

  vendorSha256 = "0b60q7ccj9czj50bs7nnyjngw76wr2w4hnj5c14cmyzcvmj8gisq";

  subPackages = [ "gotests" ];
}
