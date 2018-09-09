const router = function (controller, action, callback) {
    document.addEventListener('DOMContentLoaded', function () {
        let body = document.body;
        let current_controller = body.getAttribute("controller");
        let current_action = body.getAttribute("action");
        if (current_controller === controller && current_action === action) {
            return callback();
        } else if (current_controller === controller && Array.isArray(action) && action.includes(current_action)) {
            return callback();
        }
    });
};
export default router;
