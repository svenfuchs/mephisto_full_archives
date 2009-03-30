config.to_prepare do
  MephistoController.send :include, MephistoFullArchives::MephistoController
end