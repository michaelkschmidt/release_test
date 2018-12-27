defmodule StripPlugin do
  alias Mix.Releases.{App, Release}
  # Distillery Behaviour

  def before_assembly(release) do
    release
  end

  def before_assembly(%Release{} = release, _opts) do
    release
  end

  def after_assembly(%Release{} = release, _opts) do
    path = release.profile.output_dir

    case :beam_lib.strip_release(String.to_charlist(path)) do
      {:ok, _} ->
        IO.puts "Release Strip Successful"
        :ok

       {:error, :beam_lib, reason} ->
        IO.puts "Release Strip Failed"
        {:error, {:archiver, {:beam_lib, reason}}}
    end

    # old_cwd = File.cwd!()
    # lib_dir = Path.join([path, "lib"])
    # File.cd(lib_dir)

    # for app_name <- File.ls!() do
    #   zip_app(app_name)
    # end

    # File.cd(old_cwd)

    release
  end

  def before_package(%Release{} = release, _opts) do
    release
  end

  def after_package(%Release{} = release, _opts) do
    release
  end

  def after_cleanup(_args, _opts) do
    :noop
  end

  defp zip_app(app_name) do
    ebin_files =
      for ebin_file <- Path.wildcard("#{app_name}/ebin/*") do
        to_charlist(ebin_file)
      end

    :zip.create(
      '#{app_name}.ez',
      ebin_files,
      compress: :all,
      uncompress: ['.beam', '.app']
    )

    File.rm_rf(Path.join([app_name, "ebin"]))

    # This will only succeed if the priv folder is empy
    File.rmdir(app_name)
  end
end
