$(function () {
    $('#place-bid-button').click(function (e) {
        e.preventDefault();
        const bidAmount = $('#Lot_NextBidAmount').val();
        const lotId = $('#Lot_Id').val();
        const saleId = $('#Lot_SaleId').val();
        const bid = { amount: bidAmount, lotId: lotId, saleId: saleId };

        $.ajax({
            type: "POST",
            url: "/Lot/Bid/",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify(bid),
            success: function (result) {
                $('#Lot_CurrentPrice').val(result.currentPrice);
                $('#Lot_NextBidAmount').val(result.nextBidAmount);
            }
        });
    });
});

