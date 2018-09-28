/*
import Media.Primitives as Primitives exposing (NotFound)
import Elm.Kernel.Scheduler exposing (binding, fail, succeed)
import Elm.Kernel.Utils exposing (Tuple0, Tuple2)
*/

// PLAY, PAUSE


var _Media_pause = F(function (id) {
    return _Media_withNode(id, function (node) {
        node.pause();
        return __Utils_Tuple0;
    });
});

function _Media_withNode(id, doStuff) {
    return __Scheduler_binding(function (callback) {
        var node = document.getElementById(id);
        callback(node
            ? __Scheduler_succeed(doStuff(node))
            : __Scheduler_fail(__Primitives_NotFound(id))
        );
    });
}
