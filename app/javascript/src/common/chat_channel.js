import createChannel from "./create_channel";

class ChatChannel {
    constructor() {
        let _this = this;
        this.fetchCommentsCallback = null;
        this.fetchRoomCallback = null;
        this.fetchUsersCallback = null;
        this.channel = createChannel("ChatChannel", {
            received(params) {
                if (params.fetch_comments) {
                    if (_this.fetchCommentsCallback) _this.fetchCommentsCallback(params);
                }

                if (params.fetch_room) {
                    if (_this.fetchRoomCallback) _this.fetchRoomCallback(params);
                }

                if (params.fetch_users) {
                    if (_this.fetchUsersCallback) _this.fetchUsersCallback(params);
                }
            }
        });
    }

    connected(data = {}) {
        this.channel.perform("connected", data);
    }

    setFetchCommentsCallback(callback) {
        this.fetchCommentsCallback = callback;
    }

    setFetchRoomCallback(callback) {
        this.fetchRoomCallback = callback;
    }

    setFetchUsersCallback(callback) {
        this.fetchUsersCallback = callback;
    }
}

export default ChatChannel;
