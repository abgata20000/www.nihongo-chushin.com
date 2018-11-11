import router from './../libs/router'
import ColorForm from './../forms/color_form';

router('my_pages', ['show', 'update'], () => {
    ColorForm.start();
});
