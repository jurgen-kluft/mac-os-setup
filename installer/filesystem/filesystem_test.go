package filesystem

import (
	"io/ioutil"
	"os"
	"path/filepath"
	"testing"
)

func TestCopyFile(t *testing.T) {
	tempdir, err := ioutil.TempDir("", "")
	if err != nil {
		t.Error(err)
	}
	defer os.RemoveAll(tempdir)

	file := filepath.Join(tempdir, "file.txt")

	err = CopyFile("./testdata/file.txt", file)
	if err != nil {
		t.Error(err)
	}

	_, err = os.Stat(file)
	if err != nil && err == os.ErrNotExist {
		t.Error(err)
	}
}

func TestCopyDir(t *testing.T) {
	tempdir, err := ioutil.TempDir("", "")
	if err != nil {
		t.Error(err)
	}
	defer os.RemoveAll(tempdir)

	folder := filepath.Join(tempdir, "folder/folder")

	err = CopyDir("./testdata/mountain", folder)
	if err != nil {
		t.Error(err)
	}

	_, err = os.Stat(folder)
	if err != nil && err == os.ErrNotExist {
		t.Error(err)
	}

	_, err = os.Stat(filepath.Join(folder, "everest.txt"))
	if err != nil && err == os.ErrNotExist {
		t.Error(err)
	}
}

func TestDir(t *testing.T) {
	tempdir, err := ioutil.TempDir("", "")
	if err != nil {
		t.Error(err)
	}
	defer os.RemoveAll(tempdir)

	folder := filepath.Join(tempdir, "folder")
	err = CopyDir("./testdata", folder)
	if err != nil {
		t.Error(err)
	}

	testdata := Dir(folder)

	if testdata.String() != folder {
		t.Error(errors.New("wrong path"))
	}

	err = testdata.Copy("/mountain", "/test")
	if err != nil {
		t.Error(err)
	}

	err = testdata.Rename("/test/everest.txt", "/test/everest2.txt")
	if err != nil {
		t.Error(err)
	}

	_, err = testdata.Stat("/test/everest2.txt")
	if err != nil {
		t.Error(err)
	}

	err = testdata.Mkdir("/test/qwe/rty/uio/pas/dfg/gh", 0700)
	if err != nil {
		t.Error(err)
	}

	err = testdata.RemoveAll("/test")
	if err != nil {
		t.Error(err)
	}
}

var testSlashClean = []struct {
	Value  string
	Result string
}{
	// Already clean
	{"", "/"},
	{"/abc", "/abc"},
	{"/abc/def", "/abc/def"},
	{"/a/b/c", "/a/b/c"},
	{".", "/"},
	{"..", "/"},
	{"../..", "/"},
	{"../../abc", "/abc"},
	{"/abc", "/abc"},
	{"/", "/"},

	// Remove trailing slash
	{"abc/", "/abc"},
	{"abc/def/", "/abc/def"},
	{"a/b/c/", "/a/b/c"},
	{"./", "/"},
	{"../", "/"},
	{"../../", "/"},
	{"/abc/", "/abc"},

	// Remove doubled slash
	{"abc//def//ghi", "/abc/def/ghi"},
	{"//abc", "/abc"},
	{"///abc", "/abc"},
	{"//abc//", "/abc"},
	{"abc//", "/abc"},

	// Remove . elements
	{"abc/./def", "/abc/def"},
	{"/./abc/def", "/abc/def"},
	{"abc/.", "/abc"},

	// Remove .. elements
	{"abc/def/ghi/../jkl", "/abc/def/jkl"},
	{"abc/def/../ghi/../jkl", "/abc/jkl"},
	{"abc/def/..", "/abc"},
	{"abc/def/../..", "/"},
	{"/abc/def/../..", "/"},
	{"abc/def/../../..", "/"},
	{"/abc/def/../../..", "/"},
	{"abc/def/../../../ghi/jkl/../../../mno", "/mno"},

	// Combinations
	{"abc/./../def", "/def"},
	{"abc//./../def", "/def"},
	{"abc/../../././../def", "/def"},
}

func TestSlashClean(t *testing.T) {
	for _, test := range testSlashClean {
		val := SlashClean(test.Value)
		if val != test.Result {
			t.Errorf("Incorrect value on SlashClean for %v; want: %v; got: %v", test.Value, test.Result, val)
		}
	}
}
