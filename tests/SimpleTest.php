<?php

namespace Project;

use PHPUnit\Framework\TestCase;
use GuzzleHttp\Client;

class SimpleTest extends TestCase
{
    public function testBasicTest()
    {
       	$client = new Client([
            'base_uri' => 'http://127.0.0.1'
        ]);
  
        $response = $client->get('/');

        $this->assertEquals(200, $response->getStatusCode());
    }
}