#!/bin/bash

rm -f *.out

sudo -su hdfs hadoop fs -rm -R -skipTrash /automation/incremental
sudo -su hdfs hadoop fs -mkdir /automation/incremental
sudo -su hdfs hadoop fs -chmod -R 777 /automation/incremental
sudo -su hdfs hadoop fs -ls /automation

sudo rm -Rf /tmp/testdb/sandbox
sudo mkdir /tmp/testdb/sandbox
sudo chmod -R 777 /tmp/testdb/sandbox

sqlshell.sh -f create_test_data_0.sql > create_test_data_0.out
sqlshell.sh -f do_full.sql > create_0_bkp_full.out

sqlshell.sh -f check_test_data_1.sql > check_test_data_1.out
sqlshell.sh -f change_test_data_1.sql > change_test_data_1.out
sqlshell.sh -f do_inc.sql > change_1_bkp_ink.out

sqlshell.sh -f check_test_data_2.sql > check_test_data_2.out
sqlshell.sh -f change_test_data_2.sql > change_test_data_2.out
sqlshell.sh -f do_inc.sql > change_2_bkp_ink.out

sqlshell.sh -f check_test_data_3.sql > check_test_data_3.out
sqlshell.sh -f change_test_data_3.sql > change_test_data_3.out
sqlshell.sh -f do_inc.sql > change_3_bkp_ink.out

sqlshell.sh -f check_test_data_4.sql > check_test_data_4.out
sqlshell.sh -f change_test_data_4.sql > change_test_data_4.out
sqlshell.sh -f do_full.sql > change_4_bkp_full.out

sqlshell.sh -f get_bkps_list.sql > get_bkps_list.out
