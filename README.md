## build
>docker build -t texlive:2024 .


## install
<~/.bashrc>  
alias tex2pdf='docker run --rm -it -w /workdir -v $PWD:/workdir texlive:2024 /tex2pdf.sh '  

>source ~/.bashrc

## Usage
>tex2pdf temp.tex


