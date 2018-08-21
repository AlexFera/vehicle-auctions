"use strict";

var connection = new signalR.HubConnectionBuilder().withUrl("/biddingHub").build();

connection.start().catch(function (err) {
    return console.error(err.toString());
});

connection.on("ReceiveMessage", function (user, message) {
    toastr.options.escapeHtml = true;
    toastr.options.closeButton = true;
    toastr.options.preventDuplicates = true;
    toastr.options.positionClass = 'toast-top-center';

    toastr.info("A new bid placed!");

    $('#Lot_CurrentPrice').val(message.currentPrice);
    $('#Lot_NextBidAmount').val(message.nextBidAmount);
});