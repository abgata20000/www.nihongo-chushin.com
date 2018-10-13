const DEFAULT_SHOW_COMMENT_COUNT = 30;
const DEFAULT_COMMENT_DISCONNECTED_TIME = 900;
const DEFAULT_CONNECTION_DISCONNECTED_TIME = 60;
const RoomModule = {
    namespaced: true,
    state: {
        room: {
            show_comment_count: DEFAULT_SHOW_COMMENT_COUNT,
            comment_disconnected_time: DEFAULT_COMMENT_DISCONNECTED_TIME,
            connection_disconnected_time: DEFAULT_CONNECTION_DISCONNECTED_TIME,
        }
    },
    getters: {
        room(state) {
            return state.room;
        }
    },
    mutations: {
        updateRoom(state, payload) {
            state.room = payload;
        }
    },
    actions: {
        updateRoom({commit}, payload) {
            commit("updateRoom", payload);
        }
    }
};
export default RoomModule;
