FROM node:14.18.0-alpine3.14
RUN addgroup app && adduser -S -G app app
USER app
WORKDIR /app
RUN mkdir data
# if package.json hasn't been changed, then npm i will use its cache
COPY package.json .
RUN npm i
COPY . ./
ENV API_URL=http://api.example.com
EXPOSE 3000
ENTRYPOINT ["npm", "start"]