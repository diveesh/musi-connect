function fillResultsTable(tBodyId, tableId, users) {
    var tbody = document.getElementById(tBodyId);
    $('#' + tBodyId).empty();
    for (var i = 0; i < users.length; i++) {
        var user = users[i];
        var row = document.createElement('tr');
        var number = document.createElement('td');
        var name = document.createElement('td');
        var email = document.createElement('td');
        var instruments = document.createElement('td');
        var numberP = document.createElement('p');
        numberP.innerHTML = i + 1;
        var nameP = document.createElement('p');
        nameP.innerHTML = user.first_name + " " + user.last_name;
        var emailP = document.createElement('p');
        emailP.innerHTML = user.email_address;
        var instrumentsP = document.createElement('p');
        instrumentsP.innerHTML = user.instruments.join(",");
        instrumentsP.className = 'iffyTip wd250';
        number.appendChild(numberP);
        name.appendChild(nameP);
        email.appendChild(emailP);
        instruments.appendChild(instrumentsP);
        row.appendChild(number);
        row.appendChild(name);
        row.appendChild(email);
        row.appendChild(instruments);
        row.id = 'row' + (i + 1);
        tbody.appendChild(row);

        var closure = function() {
            var rowId = row.id;
            var userId = user.id;
            $('#resultsTable tbody').off('click', '#' + rowId);
            $('#resultsTable tbody').on('click', '#' + rowId, function() {
                window.open('/users/display_profile/' + userId);
            });
        };
        closure();
        

        $('#' + row.id).css('cursor', 'pointer');
        $(function() {
            $("#" + row.id).hover(
            function() {
                $(this).css('background-color', '#ff0')
            }, function() {
                $(this).css('background-color', '')
            });
        });
    }
}
