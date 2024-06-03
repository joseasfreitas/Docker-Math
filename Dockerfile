# Use the official Apache image from the Docker Hub
FROM httpd:latest

# Install OpenSSL and enable necessary modules
RUN apt-get update && apt-get install -y openssl && apt-get clean \
    && sed -i '/LoadModule ssl_module modules\/mod_ssl.so/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule cgi_module modules\/mod_cgi.so/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule alias_module modules\/mod_alias.so/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule authz_core_module modules\/mod_authz_core.so/s/^#//g' /usr/local/apache2/conf/httpd.conf \
    && sed -i '/LoadModule unixd_module modules\/mod_unixd.so/s/^#//g' /usr/local/apache2/conf/httpd.conf

RUN sed -i '/LoadModule alias_module modules\/mod_alias.so/a LoadModule autoindex_module modules/mod_autoindex.so' /usr/local/apache2/conf/httpd.conf

# Copy the custom configuration file
COPY apache2.conf /usr/local/apache2/conf/httpd.conf

# Copy the SSL certificate and key
COPY ssl/server.crt /usr/local/apache2/conf/server.crt
COPY ssl/server.key /usr/local/apache2/conf/server.key

# Copy the math CGI script
COPY math.cgi /usr/local/apache2/cgi-bin/math.cgi

# Copy the index.html
COPY index.html /usr/local/apache2/htdocs/

# Make sure the CGI script is executable
RUN chmod +x /usr/local/apache2/cgi-bin/math.cgi

# Expose port 443 for HTTPS
EXPOSE 443

# Run Apache in the foreground
CMD ["httpd-foreground"]
