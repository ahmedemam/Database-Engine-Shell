#!/usr/bin/env bash


# SELECT * FROM TABLE
# SELECT * FROM TABLE WHERE ....
# SELECT * FROM TABLE WHERE .... ORDER BY ....

# Parameters : all - TableName - Where - Columns/Values
# Parameters : Order By .....

# databaseName - tableName - all
function select_all_table() {
    if [[ $3 == '*' ]] && [[ $2 != '' ]] && [[ $1 != '' ]]; then
    # get meta_data - columns names
    # get columns of specfiic table

    else
        echo '#> WRONG PARAMETERS.'
    fi
}