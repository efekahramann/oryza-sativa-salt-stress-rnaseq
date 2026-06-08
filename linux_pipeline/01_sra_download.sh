##terminali aç ve aşağıdaki kopyala:

wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

tar -vxzf sratoolkit.tar.gz

export PATH=$PATH:$PWD/sratoolkit.3.1.0-ubuntu64   direkt terminale yapıştır
    nano .bashrc de en alta yazabilirsin Control O enter xontrol X ile çıkıp

fasterq-dump SRR******* --split-files -e 11 -O .     paired end dosyalar için
                                                     e <- kullanılan çekirdek sayısı
                                                     . <- bulunduğumuz klasöre indirmemizi sağlar
