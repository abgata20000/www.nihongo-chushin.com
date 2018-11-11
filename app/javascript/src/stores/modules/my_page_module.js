const MyPageModule = {
    namespaced: true,
    state: {
        myPage: {}
    },
    getters: {
        myPage(state) {
            return state.myPage;
        },
        sound(state) {
            return state.myPage.sound;
        }
    },
    mutations: {
        updateMyPage(state, payload) {
            state.myPage = payload;
        }
    },
    actions: {
        updateMyPage({commit}, payload) {
            commit("updateMyPage", payload);
        }
    }
};
export default MyPageModule;
