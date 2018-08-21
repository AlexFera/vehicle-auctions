$(document).ready(function () {
    $('#place-bid-button').click(function (e) {
        e.preventDefault();
        const bidAmount = $('#Lot_NextBidAmount').val();
        const lotId = $('#Lot_Id').val();
        const saleId = $('#Lot_Sale_Id').val();
        const bid = { amount: bidAmount, lotId: lotId, saleId: saleId };

        $.ajax({
            type: "POST",
            url: "/Lot/Bid/",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(bid),
            success: function (result) {
            }
        });
    });
});

