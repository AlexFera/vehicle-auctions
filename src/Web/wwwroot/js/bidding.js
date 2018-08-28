"use strict";

var connection = new signalR.HubConnectionBuilder().withUrl("/biddingHub").build();

connection.start().catch(function (err) {
    return console.error(err.toString());
});

connection.on("ReceiveMessage", function (user, message) {
    const lotId = Number(getParameterByName('lotId'));
    const messageLotId = Number(message.id);

    if (lotId === messageLotId) {
        toastr.options.escapeHtml = true;
        toastr.options.closeButton = true;
        toastr.options.preventDuplicates = true;
        toastr.options.positionClass = 'toast-top-center';

        toastr.info("A new bid has been placed!");

        $('#Lot_CurrentPrice').fadeOut(500, function () {
            $(this).val(message.currentPrice + ' €').fadeIn(500);
        });
        $('#Lot_NextBidAmount').fadeOut(500, function () {
            $(this).val(message.nextBidAmount).fadeIn(500);
        });
        $('#bidding-status').show();
        if (message.biddingStatus === 1) {
            if (user === $('#signedin-username').text()) {
                $('#winning-status').show();
                $('#losing-status').hide();
            }
            else {
                $('#winning-status').hide();
                $('#losing-status').show();
            }
        }
        else if (message.biddingStatus === 2) {
            $('#winning-status').hide();
            $('#losing-status').show();
        }
    }
});