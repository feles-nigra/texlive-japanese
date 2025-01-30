# alipineコンテナにtexliveをインストール後の日本語フォントの適用  

0. msというフォルダに、msgothic.ttc  msmincho.ttcというファイルが入っている  
  
1. .ttcの入ったフォルダをコピー。ここではms   
> docker cp ms container_name:/usr/share/fonts  
   
2. フォントキャッシュ更新  
> fc-cache -fv  
  
3. フォントの存在確認  
> fc-list | grep "MS"  
  
4. フォントの設定  
> echo "Map ms.map" >> /usr/local/texlive/2024/texmf-dist/web2c/updmap.cfg  
  
5. フォントマップ作成  
> echo "msgothic.ttc MS-Gothic" > /usr/local/texlive/2024/texmf-dist/fonts/map/dvips/updmap/ms.map  
> echo "msmincho.ttc MS-Mincho" >> /usr/local/texlive/2024/texmf-dist/fonts/map/dvips/updmap/ms.map  

**[フォントファイル名] [フォント指定名]**  
フォントファイル名:fc-listで表示された、１で置いたファイルの本体。コロンの左側これ=>meiryo.ttc: Meiryo  
フォント指定名: fc-listで表示された、フォントファイルの指定名。コロンの右側meiryo.ttc: Meiryo<=これ  
  
  
6. 設定の反映  
> mktexlsr  
> updmap-sys  

7. コンパイルテスト  
```
\documentclass{article}
\usepackage{fontspec}

\begin{document}

\fontspec{MS-Gothic}
MS-Gothic \\
あいうえお伊藤 \\
\\
\fontspec{MS-Mincho}
MS-Mincho \\
あいうえお伊藤 \\
\\
\fontspec{HaranoAjiMincho}
HaranoajiMincho \\
あいうえお伊藤 \\
\\
\fontspec{HaranoAjiGothic}
HaranoAjiGothic \\
あいうえお伊藤 \\
\\
\fontspec{Meiryo}
Meiryo \\
あいうえお伊藤 \\
\end{document}
```
