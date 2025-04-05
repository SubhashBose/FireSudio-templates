/*
 Copyright 2024 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

{ pkgs, ... }: {
  packages = [
  ];
  bootstrap = ''
    mkdir "$out"
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    shopt -s dotglob; cp -r ${./content}/* "$out"
    chmod -R +w "$out"
    #mv "$out/.venv/.gitignorex" "$out/.venv/.gitignore"
    #find "$out/.venv" -name '*' -type f -exec sed -i "s#/home/user/main#/home/user/$WS_NAME#g" {} +
    #mkdir /home/user/.jupyter
    #pwd > $out/tmp0.out; ls -la ../ >> $out/tmp0.out
    #cp -rf ${./jupyter_lab_config.py} "/home/user/.jupyter/jupyter_lab_config.py"
    #cp -rf ${./jupyter_lab_config.py} "$out/jupyter_lab_config.py"
    cp -rf ${./.jupyter} "$out/"
  '';
}