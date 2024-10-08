#! /bin/sh -e
## Confgure, COmplile Link Go
[ -e Configure ] && cfg=Configure
clg(){ local x="$1"
        ./${cfg:-configure} "$x" &&\
        SYSPATH=$${PWD} make -C ../lambdanative
        cd ~/apps
        unzip -o $(ls -tr ~/.cache/lambdanative/packages/$x*.zip|tail -1)
        cd $x
        chmod +x $x
        echo "Invoking $PWD/$x..."
        ./$x
}
pwd
xs=($(cd apps; ls))
if [ ${#xs[@]} -lt 2 ]
then x=${xs[0]}
else select x in  "${xs[@]}"
   do if [ -n "$x" ]
      then break
      fi
   done
fi
clg $x
result=$?
echo Result: $result
exit $result
