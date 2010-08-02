use utf8;
use strict;
use Test::More;

use MusicBrainz::Server::Test
    qw( xml_ok schema_validator ),
    ws_test => { version => 1 };

ws_test 'lookup track',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#">
  <track id="c869cc03-cb88-462b-974e-8e46c1538ad4">
    <title>Rock With You</title><duration>255146</duration>
  </track>
</metadata>';

ws_test 'lookup track with a single artist',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=artist' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#">
  <track id="c869cc03-cb88-462b-974e-8e46c1538ad4">
    <title>Rock With You</title><duration>255146</duration>
    <artist id="a16d1433-ba89-4f72-a47b-a370add0bb55">
      <sort-name>BoA</sort-name><name>BoA</name>
    </artist>
  </track>
</metadata>';

ws_test 'lookup track with multiple artists',
    '/track/84c98ebf-5d40-4a29-b7b2-0e9c26d9061d?type=xml&inc=artist' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#">
  <track id="84c98ebf-5d40-4a29-b7b2-0e9c26d9061d">
    <title>the Love Bug (Big Bug NYC remix)</title><duration>222000</duration>
    <artist id="22dd2db3-88ea-4428-a7a8-5cd3acf23175">
      <sort-name>m-flo♥BoA</sort-name><name>m-flo♥BoA</name>
    </artist>
  </track>
</metadata>';

sub todo {

ws_test 'lookup track with releases',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=releases' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with puids',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=puids' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with artist-relationships',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=artist-rels' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with label-relationships',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=label-rels' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with release-relationships',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=release-rels' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with track-relationships',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=track-rels' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with url-relationships',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=url-rels' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with tags',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=tags' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with user-tags',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=user-tags' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with ratings',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=ratings' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with user-ratings',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=user-ratings' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

ws_test 'lookup track with isrcs',
    '/track/c869cc03-cb88-462b-974e-8e46c1538ad4?type=xml&inc=isrcs' =>
    '<?xml version="1.0" encoding="UTF-8"?>
<metadata xmlns="http://musicbrainz.org/ns/mmd-1.0#" />';

}

done_testing;
