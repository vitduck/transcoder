package FFmpeg::Video; 

use Moose::Role;  
use MooseX::Types::Moose qw( Str Int HashRef ); 
use namespace::autoclean; 

use experimental qw( signatures ); 

requires qw( 
    _build_video 
    _build_video_id 
    _build_video_size 
); 

has 'video', ( 
    is        => 'ro', 
    isa       => HashRef, 
    traits    => [ 'Hash' ], 
    lazy      => 1, 
    init_arg  => undef, 
    builder   => '_build_video', 

    handles   => { 
        get_video_ids  => 'keys', 
        get_video_size => 'get', 
    }
);   

has 'video_id', ( 
    is        => 'ro', 
    isa       => Str, 
    lazy      => 1, 
    init_arg  => undef, 
    builder   => '_build_video_id', 
);  

has 'video_size', ( 
    is        => 'ro', 
    isa       => HashRef,  
    traits    => [ 'Hash' ],  
    lazy      => 1, 
    init_arg  => undef, 
    builder   => '_build_video_size', 

    handles   => { 
        get_video_height => [ get => 'height' ], 
        get_video_width  => [ get => 'width'  ]
    }
); 

has 'scaled_height', ( 
    is        => 'ro', 
    isa       => Int, 
    lazy      => 1, 
    default   => 304, 
); 

has 'scaled_width', ( 
    is        => 'ro', 
    isa       => Int,  
    lazy      => 1, 
    init_arg  => undef, 
    builder   => '_build_scaled_width'
); 

sub _build_scaled_width ( $self ) { 
    my $width  = $self->get_video_width; 
    my $height = $self->get_video_height; 

    return 16 * int( $self->scaled_height * $width / $height / 16 ) 
} 

1  
