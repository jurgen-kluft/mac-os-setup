package installer

import (
	"runtime"
)

var (
	VERSION = "1.16.12"
)

var (
	GO_INSTALL_PATH = "$(HOME)/sdk/go"
)

func isGoInstalled(sh *Shell) bool {
	return sh.Exists("$(HOME)/sdk/go")
}

type Environment interface {
	EnvPush()                        // Save current state
	EnvPop()                         // Restore last state
	EnvSet(key string, value string) // Local
	EnvPut(key string, value string) // System
}

type Archiver interface {
	Extract(str string)
}

type Downloader interface {
	Download(URL string, filepath string) error
}

type FileSystem interface {
	Getwd() string
	Setwd(path string)
	Mkdir(dirpath string)
	Rm(path string)
	Mv(dstpath string, srcpath string)
	Exists(path string)
	IsDir(path string)
	SymLink(dstpath string, srcpath string)
}

type Shell struct {
}

func (sh *Shell) EnvPush() {

}
func (sh *Shell) EnvPop() {

}
func (sh *Shell) EnvSet(key string, value string) {

}
func (sh *Shell) EnvPut(key string, value string) {

}

func (sh *Shell) Extract(str string) {

}

func (sh *Shell) Download(URL string, filepath string) error {
	return nil
}

func (sh *Shell) Getwd() string {
	return ""
}
func (sh *Shell) Setwd(path string) {

}
func (sh *Shell) Mkdir(dirpath string) {

}
func (sh *Shell) Rm(path string) {

}
func (sh *Shell) Mv(dstpath string, srcpath string) {

}
func (sh *Shell) Exists(path string) bool {
	return false
}
func (sh *Shell) IsDir(path string) bool {
	return false
}
func (sh *Shell) SymLink(dstpath string, srcpath string) {

}

func (sh *Shell) Echo(str string) {

}

func InstallGo(version string, sh *Shell) error {
	sh.EnvPush()
	defer sh.EnvPop()

	sh.EnvSet("GOOS", runtime.GOOS)
	sh.EnvSet("GOARCH", runtime.GOARCH)
	sh.EnvSet("HOME", sh.Getwd())

	sh.EnvSet("VERSION", version)
	sh.EnvSet("DFILE", "go$(VERSION).$(GOOS)-$(GOARCH).tar.gz")

	sh.Echo("Installing Go $(VERSION) from $(DFILE)")
	sh.Echo("Downloading $(DFILE) ...")

	TMPTAR := "$(HOME)/tmp/go.tar.gz"
	result := sh.Download("https://golang.google.cn/dl/$(DFILE)", "$(TMPTAR)")

	if result != nil {
		sh.Echo("Download failed! Exiting.")
		return result
	}

	sh.Echo("Extracting $(DFILE) ...")
	sh.Extract(TMPTAR)
	sh.Mkdir("$(HOME)/dev.go/src")
	sh.Mkdir("$(HOME)/dev.go/bin")
	sh.Mkdir("$(HOME)/dev.go/pkg")
	sh.Mkdir("$(HOME)/go/src")
	sh.Mkdir("$(HOME)/go/pkg")
	sh.Mkdir("$(HOME)/go/bin")

	sh.Echo("")
	sh.Echo("Go $(VERSION) was installed.")
	sh.Echo("Make sure to relogin into your shell or run:")
	sh.Echo("    source $(HOME)/mac-os-dotfiles/.golang_paths.")
	sh.Echo("")
	sh.Echo("to update your environment variables.")
	sh.Echo("Tip: Opening a new terminal window usually just works. :)")
	sh.Echo("")
	sh.Echo("Removing $(DFILE) ...")

	sh.Rm(TMPTAR)
	sh.Mv("$(HOME)/go", "$(HOME)/sdk/go$VERSION")

	sh.EnvPut("GOSUMDB", "sum.golang.google.cn")
	sh.EnvPut("GOPROXY", "https://goproxy.cn")

	sh.Echo("")
	sh.Echo("Done ...")

	return nil
}
