// activestorage refs: https://techracho.bpsinc.jp/hachi8833/2018_02_06/52179
import * as ActiveStorage from "activestorage";
ActiveStorage.start();
// rails-ujs refs: https://qiita.com/mokuo/items/a50a27a83c3328c116a7
import Rails from 'rails-ujs';
Rails.start();
// action_cableを利用る場合は↓が参考になりそう
// refs: https://techracho.bpsinc.jp/hachi8833/2018_01_15/50860
// router
import "./controllers/sessions";
import "./controllers/my_pages";
