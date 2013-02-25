@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set BASE_DIR=%HOME%\.jg-vim
::call mkdir %BASE_DIR%\.vim\bundle
call mklink /J %HOME%\.vim %BASE_DIR%\.vim
call mklink %HOME%\_gvimrc %BASE_DIR%\.gvimrc
call mklink %HOME%\_vimrc %BASE_DIR%\.vimrc

call git clone https://github.com/gmarik/vundle.git %HOME%/.vim/bundle/vundle
call vim -u %BASE_DIR%/.vimrc +BundleInstall! +BundleClean +qall
