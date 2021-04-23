// +build tools

package main

import (
	_ "github.com/cweill/gotests"
	_ "github.com/golangci/golangci-lint/cmd/golangci-lint"
	_ "github.com/lighttiger2505/sqls"
	_ "github.com/mattn/efm-langserver"
	_ "golang.org/x/tools/gopls"
)
