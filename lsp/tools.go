// +build tools

package main

import (
	_ "github.com/cweill/gotests/gotests"
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	_ "github.com/lighttiger2505/sqls"
	_ "github.com/mattn/efm-langserver"
	_ "golang.org/x/tools/cmd/goimports"
	_ "golang.org/x/tools/gopls"
	_ "mvdan.cc/sh/v3/cmd/shfmt"
)
