#!/bin/bash
FROM registry.lab.example.com/ubi9-beta/ubi
MAINTAINER nobody@redhat.com
RUN dnf  config-manager  --add-repo "http://content/rhel9.0/x86_64/dvd/AppStream"
RUN echo "gpgcheck=0" >> /etc/yum.repos.d/content_rhel9.0_x86_64_dvd_AppStream.repo
RUN dnf  config-manager  --add-repo "http://content/rhel9.0/x86_64/dvd/BaseOS"
RUN echo "gpgcheck=0" >> /etc/yum.repos.d/content_rhel9.0_x86_64_dvd_BaseOS.repo
#COPY .repo/*   /etc/yum.repos.d/
RUN dnf install -y ghostscript  enscript
RUN mkdir /opt/incoming  
RUN mkdir /opt/outgoing
RUN echo "while true"  >> /usr/local/bin/ascii2pdf
RUN echo "do"  >> /usr/local/bin/ascii2pdf
RUN echo "CURRENT_DIR='/opt/incoming'"  >> /usr/local/bin/ascii2pdf
RUN echo "#app=#(ls -Art1 datas | tail -n 1)"  >> /usr/local/bin/ascii2pdf
RUN echo "text1 "  >> /usr/local/bin/ascii2pdf
RUN echo "enscript /opt/incoming/-o - | ps2pdf - /opt/outgoing/.txt"  >> /usr/local/bin/ascii2pdf
RUN echo "done"  >> /usr/local/bin/ascii2pdf
RUN sed -i 's/text1/echo $FILE/g' /usr/local/bin/ascii2pdf
RUN sed -i 's/-o/$FILE  -o/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/.txt/$FILE/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/#app=#/FILE=$/g'  /usr/local/bin/ascii2pdf
RUN sed -i 's/datas/${CURRENT_DIR}/g'  /usr/local/bin/ascii2pdf
RUN chmod 777 /usr/local/bin/ascii2pdf 
CMD [ "/bin/bash", "-c", "/usr/local/bin/ascii2pdf" ]
