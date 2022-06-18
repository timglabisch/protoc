use prost_build::Config;
use glob::glob;

fn main() -> ::std::io::Result<()> {

    let files = glob("/proto/**/*.proto").expect("could not fint proto files");
    
    let os_files = files.map(|p| p.expect("invalid path").to_path_buf()).collect::<Vec<_>>();


    Config::new()
        .out_dir("/proto_out")
        .protoc_arg("--experimental_allow_proto3_optional")
        .compile_protos(
            os_files.as_slice(),
            &["/proto"]
        )?;
    Ok(())
}
