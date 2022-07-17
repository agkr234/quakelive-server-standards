# the image is based on the quake live server standards base image
FROM quakeliveserverstandards/ql-server

COPY --chown=steam:steam minqlx-plugins/ /home/steam/ql/minqlx-plugins

COPY --chown=steam:steam download-workshop.sh /home/steam/ql/download-workshop.sh

# 元のイメージ(quakeliveserverstandards/ql-server)のスタートアップコマンドを上書き。自動でminqlx-plugins内にあるプラグインを読み込む + workshopをダウンロードするために。
CMD \
    # determine installed plugins - contributed by em92 (https://github.com/MinoMino/minqlx/issues/105)
    INSTALLED_QLX_PLUGINS=`find ${HOMEDIR}/ql/minqlx-plugins/*.py | grep -v "__init__" | sed 's!.*/!!' | sed 's!\.py!!' | xargs | tr ' ' ', '` \
    && set -x \
    # if NET_PORT is not set then set it to the default port of 27960
    && export NET_PORT=${NET_PORT:-27960} \
    # if ZMQ_STATS_PORT is not set then set it to NET_PORT
    && export ZMQ_STATS_PORT=${ZMQ_STATS_PORT:-$NET_PORT} \
    # if ZMQ_RCON_PORT is not set then set it to NET_PORT + 1000
    && export ZMQ_RCON_PORT=${ZMQ_RCON_PORT:-$(($NET_PORT + 1000))} \
    # if SERVERSTARTUP is not set we need to set it because otherwise the server will
    # not function properly
    && export SERVERSTARTUP=${SERVERSTARTUP:-startRandomMap} \
    # if QLX_PLUGINS is not set then set it to the list of present plugins in the minqlx-plugins directory
    && export QLX_PLUGINS=${QLX_PLUGINS:-$INSTALLED_QLX_PLUGINS} \
    # workshop.txtにある項目を全てダウンロード
    && ${HOMEDIR}/ql/download-workshop.sh \
    # start the minqlx extended quake live server
    && ./ql/run_server_x64_minqlx.sh \
    # only attach a cvar parameter if the environment variable is set
    ${NET_PORT:++set net_port ${NET_PORT}} \
    ${ZMQ_RCON_PORT:++set zmq_rcon_port ${ZMQ_RCON_PORT}} \
    ${ZMQ_STATS_PORT:++set zmq_stats_port ${ZMQ_STATS_PORT}} \
    ${SV_HOSTNAME:++set sv_hostname ${SV_HOSTNAME}} \
    ${SV_TAGS:++set sv_tags ${SV_TAGS}} \
    ${G_PASSWORD:++set g_password ${G_PASSWORD}} \
    ${SV_MAXCLIENTS:++set sv_maxClients ${SV_MAXCLIENTS}} \
    ${SV_PRIVATECLIENTS:++set sv_privateClients ${SV_PRIVATECLIENTS}} \
    ${SV_PRIVATEPASSWORD:++set sv_privatePassword ${SV_PRIVATEPASSWORD}} \
    ${COM_HUNKMEGS:++set com_hunkMegs ${COM_HUNKMEGS}} \
    ${QLX_PLUGINS:++set qlx_plugins ${QLX_PLUGINS}}