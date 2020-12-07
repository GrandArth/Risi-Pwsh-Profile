# Risi-Pwsh-Profile
这份配置文件为我本人写的一系列应用在各种场景下的模块合集,
该系列模块默认的Powershell版本是 PS Core 7.0 及以上,
并时刻保持和最新稳定版本兼容.

函数的具体变量类型和顺序请查阅配置文件。

## mmecab

This is a workaround for windows mecab, since the only way mecab would work probably on windows is via direct file input output.
This module create temp file for mecab to take as input and use as output.
Mecabの文字化けを直す.

## Jpexl
> 外部依赖 cjpegxl djpegxl

递归的编码解码目录下的文件为/从JPEGXL

## genlist
> 外部依赖: Mediainfo

根据目录内指定格式的文件的ID3标签生成一份曲目列表, 支持多张专辑.

## Covergen
> 外部依赖: ImageMagick

使用ImageMagick, 将并非标准正方形的图像放入白色正方形背景中 (常用于BD等非正方形的标签), 以便在音乐文件标签里完整显示.
该函数生成的图像以原图长与宽的最大值作为正方形的边长长度.

## enb64
> 变量: 字符串

将一段UTF-8编码的字符串转码为BASE64.

## deb64
> 变量: 字符串

解码一段UTF-8编码的BASE64字符串/

## rs
> 变量: 长度

生成一段指定长度, 由大小写字母数字和 "-" 构成的随机字符串并复制到剪切板.
是RandomString函数的简化前端.

## guid

生成一段GUID并复制到剪切板.

## spgit

让git使用代理端口

## upgit

清除Git的代理.

## smhttp

使用Python在8000端口建立一个服务器.

## gtype

递归批量获取文件的类型， 默认根目录为当前目录

## mdel

递归批量删除某一类型的文件， 默认根目录为当前目录

## imgconv / fimgconv

已经过时， 请使用VIPS进行转化。