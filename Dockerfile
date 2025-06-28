# Use official nginx image as base
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy maintenance page files to nginx html directory
COPY . /usr/share/nginx/html/

# Create custom nginx configuration for maintenance mode
RUN echo 'server {' > /etc/nginx/conf.d/maintenance.conf && \
    echo '    listen 80;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    server_name _;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    root /usr/share/nginx/html;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    index index.html;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    location / {' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '        try_files $uri $uri/ /index.html;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    }' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    # Security headers' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    add_header X-Frame-Options DENY;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    add_header X-Content-Type-Options nosniff;' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '    add_header X-XSS-Protection "1; mode=block";' >> /etc/nginx/conf.d/maintenance.conf && \
    echo '}' >> /etc/nginx/conf.d/maintenance.conf

# Remove default nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]