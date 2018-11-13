# a multi-step process, one step for building, one step for running
# this will make for a small container
# the builder step, that creates the build folder in the current directory
FROM node:alpine as builder
WORKDIR  '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
##############################################
# end builder phase
##############################################

FROM nginx
# Elastic Beanstalk needs to see an exposed port
EXPOSE 80

# copy from the builder phase
COPY  --from=builder  /app/build  /usr/share/nginx/html
