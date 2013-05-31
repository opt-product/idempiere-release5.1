#!/bin/sh
#
echo Set Unix Environment
# $Id: RUN_UnixEnvTemplate.sh,v 1.3 2004/03/11 05:41:13 jjanke Exp $

echo ===================================
echo Setup Client Environment
echo ===================================

JAVA_HOME=@JAVA_HOME@
export JAVA_HOME
IDEMPIERE_HOME=@IDEMPIERE_HOME@
export IDEMPIERE_HOME

echo "\$JAVA_HOME is set to $JAVA_HOME and \$IDEMPIERE_HOME is set to $IDEMPIERE_HOME"

# ORACLE_HOME=/var/oracle/OraHome92
# export ORACLE_HOME

# Please check Oracle Installation documentation for details
# LD_LIBRARY_PATH=$ORACLE_HOME/lib
# export LD_LIBRARY_PATH
