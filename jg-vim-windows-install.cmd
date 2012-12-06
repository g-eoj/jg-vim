@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.jg-vim
call git clone --recursive -b 3.0 git://github.com/g-eoj/jg-vim.git %BASE_DIR%
call mkdir %BASE_DIR%\.vim\bundle
call mklink /J %HOME%\.vim %BASE_DIR%\.vim
call mklink %HOME%\.gvimrc %BASE_DIR%\.gvimrc
call mklink %HOME%\_gvimrc %BASE_DIR%\.gvimrc
call mklink %HOME%\.vimrc %BASE_DIR%\.vimrc
call mklink %HOME%\_vimrc %BASE_DIR%\.vimrc
call mklink %HOME%\.vimrc.bundles %BASE_DIR%\.vimrc.bundles

call git clone http://github.com/gmarik/vundle.git %HOME%/.vim/bundle/vundle
call vim -u "$BASE_DIR/.vimrc.bundles" - +BundleInstall! +BundleClean +qall
