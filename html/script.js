$(function () {
    const container = $('#container');

    window.addEventListener('message', function (e) {
        if (e.data.type === 'updateLocations') {
            container.show();
            container.html('');

            e.data.players.forEach(player => {
                const circle = $('<div></div>');
                circle.addClass('player-circle');
                circle.css({
                    "left": `${player.x}%`,
                    "top": `${player.y}%`,
                    "background": `${player.color}`,
                });
                container.append(circle);
            });

        } else if (e.data.type === 'close') {
            container.hide();
        }
    });
});