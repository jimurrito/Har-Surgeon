FROM elixir:1.18.4-otp-28
#
# docker build -t jimurrito/har-surgeon:0.1.2 .
# docker build -t jimurrito/har-surgeon:latest .
# docker push jimurrito/har-surgeon:latest
# docker run -it -p 4000:4000 har-surgeon
#

#
ENV MIX_ENV=prod
#
#
RUN apt update && apt upgrade -y
RUN apt install inotify-tools -y
#
# Import files
# local (.) -> /app in docker
ADD ./ /app/
RUN mkdir /db
#
WORKDIR /app
#
RUN mix deps.get 
RUN mix compile
RUN mix assets.setup
RUN mix assets.deploy
RUN mix phx.digest
#
EXPOSE 4000
#
CMD ["mix", "phx.server"]
